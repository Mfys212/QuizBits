from fastapi import APIRouter, Depends, Request, UploadFile, File, HTTPException
from sqlalchemy.orm import Session
from typing import Optional
from app.core.database import get_db
from app.core.dependencies import get_current_user
from app.schemas.question import QuestionCreate, QuestionUpdate, QuestionRead, CoverUploadResponse
from app.services.question import (
    create_question, get_questions, 
    get_question, update_question, 
    delete_question, increment_view,
    save_upload_file
)
from app.models.user import User
import os

router = APIRouter(prefix="/questions", tags=["questions"])

@router.post("/", response_model=QuestionRead)
def create(data: QuestionCreate, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    return create_question(db, data, current_user.get("sub"))


@router.get("/", response_model=list[QuestionRead])
def list_q(skip: int = 0, limit: int = 20, category_id: Optional[int] = None, db: Session = Depends(get_db)):
    return get_questions(db, skip, limit, category_id)

@router.get("/{q_id}", response_model=QuestionRead)
def get_one(q_id: int, request: Request, db: Session = Depends(get_db)):
    ip = request.client.host
    increment_view(db, q_id, ip)
    return get_question(db, q_id)

@router.put("/{q_id}", response_model=QuestionRead)
def update(q_id: int, data: QuestionUpdate, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    return update_question(db, q_id, data, current_user.get("sub"))

@router.post("/{q_id}/cover", response_model=QuestionRead, summary="Upload / ganti cover soal yang sudah ada")
def upload_cover(
    q_id: int,
    file: UploadFile = File(..., description="File gambar cover baru"),
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    q = get_question(db, q_id)
    if not q:
        raise HTTPException(status_code=404, detail="Soal tidak ditemukan")
    if q.user_id != current_user.get("sub") and current_user.get("role") not in ["admin", "developer"]:
        raise HTTPException(status_code=403, detail="Hanya pemilik atau admin yang bisa ganti cover")
    if q.cover_url and q.cover_url.startswith("/uploads/"):
        old_path = q.cover_url.lstrip("/")
        if os.path.exists(old_path):
            try:
                os.remove(old_path)
            except:
                pass
    new_cover_url = save_upload_file(file, "covers")
    q.cover_url = new_cover_url
    db.commit()
    db.refresh(q)
    return q

@router.delete("/{q_id}")
def delete(q_id: int, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    delete_question(db, q_id, current_user.get("sub"))
    return {"message": "Soal dihapus"}

@router.post("/upload/cover-only", 
             response_model=CoverUploadResponse,
             responses={400: {"description": "File terlalu besar atau tipe tidak diizinkan"},},
             summary="Upload cover doang, return URL")
def upload_cover_only(
    file: UploadFile = File(..., description="File gambar cover"),
    current_user: User = Depends(get_current_user)
):
    cover_url = save_upload_file(file, "covers")
    return {"cover_url": cover_url, "message": "Upload berhasil"}
