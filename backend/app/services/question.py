from sqlalchemy.orm import Session
from fastapi import HTTPException, UploadFile
from app.models.question import Question
from app.models.answer import Answer
from app.schemas.question import QuestionCreate, QuestionUpdate
from app.services.activity_log import log_activity
from app.core.config import UPLOAD_DIR, ALLOWED_IMAGE_TYPES, MAX_UPLOAD_SIZE
import os
import uuid
import shutil

def create_question(db: Session, data: QuestionCreate, user_id: int):
    q = Question(
        question=data.question,
        correct_answer=data.correct_answer,
        explanation=data.explanation,
        cover_url=data.cover_url or "",
        user_id=user_id,
        category_id=data.category_id,
    )
    db.add(q)
    db.flush()
    for ans_text in data.answers:
        ans = Answer(answer=ans_text, question_id=q.id)
        db.add(ans)
    db.commit()
    db.refresh(q)
    log_activity(db, user_id, "question", "create", q.id, f"Buat soal: {q.question[:30]}")
    return q

def get_questions(db: Session, skip: int = 0, limit: int = 20, category_id: int | None = None):
    query = db.query(Question)
    if category_id:
        query = query.filter(Question.category_id == category_id)
    return query.offset(skip).limit(limit).all()

def get_question(db: Session, q_id: int):
    return db.query(Question).filter(Question.id == q_id).first()

def update_question(db: Session, q_id: int, data: QuestionUpdate, user_id: int):
    q = get_question(db, q_id)
    if not q:
        raise HTTPException(status_code=404, detail="Soal tidak ditemukan")
    if data.question is not None:
        q.question = data.question
    if data.correct_answer is not None:
        q.correct_answer = data.correct_answer
    if data.explanation is not None:
        q.explanation = data.explanation
    if data.category_id is not None:
        q.category_id = data.category_id
    if data.cover_url is not None:
        q.cover_url = data.cover_url
    if data.answers is not None:
        db.query(Answer).filter(Answer.question_id == q.id).delete()
        for ans_text in data.answers:
            db.add(Answer(answer=ans_text, question_id=q.id))
    db.commit()
    db.refresh(q)
    log_activity(db, user_id, "question", "update", q.id, "Update soal")
    return q

def delete_question(db: Session, q_id: int, user_id: int):
    q = get_question(db, q_id)
    if not q:
        raise HTTPException(status_code=404, detail="Soal tidak ditemukan")
    db.delete(q)
    db.commit()
    log_activity(db, user_id, "question", "delete", q_id, "Hapus soal")
    
def increment_view(db: Session, q_id: int, ip: str):
    from app.models.question_view import QuestionView
    q = get_question(db, q_id)
    if not q:
        return
    exists = db.query(QuestionView).filter(QuestionView.question_id==q_id, QuestionView.ip_address==ip).first()
    if not exists:
        q.views = (q.views or 0) + 1
        db.add(QuestionView(question_id=q_id, ip_address=ip))
        db.commit()

def save_upload_file(file: UploadFile, subfolder: str = "covers") -> str:
    if file.content_type not in ALLOWED_IMAGE_TYPES:
        raise HTTPException(status_code=400, detail=f"Tipe file harus: {', '.join(ALLOWED_IMAGE_TYPES)}")
    file.file.seek(0, os.SEEK_END)
    file_size = file.file.tell()
    file.file.seek(0)
    if file_size > MAX_UPLOAD_SIZE:
        raise HTTPException(status_code=400, detail=f"File terlalu besar. Maks {MAX_UPLOAD_SIZE // (1024*1024)}MB")
    ext = os.path.splitext(file.filename)[1] or ".jpg"
    unique_name = f"{uuid.uuid4().hex}{ext}"
    upload_path = os.path.join(UPLOAD_DIR, subfolder)
    os.makedirs(upload_path, exist_ok=True)
    file_path = os.path.join(upload_path, unique_name)
    with open(file_path, "wb") as buffer:
        shutil.copyfileobj(file.file, buffer)
    return f"/uploads/{subfolder}/{unique_name}"