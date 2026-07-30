from sqlalchemy.orm import Session
from fastapi import HTTPException
from app.models.comment import Comment
from app.schemas.comment import CommentCreate, CommentUpdate

def create_comment(db: Session, data: CommentCreate, user_id: int):
    c = Comment(comment=data.comment, question_id=data.question_id, user_id=user_id)
    db.add(c)
    db.commit()
    db.refresh(c)
    return c

def get_comments_by_question(db: Session, question_id: int):
    return db.query(Comment).filter(Comment.question_id==question_id).order_by(Comment.created_at.desc()).all()

def update_comment(db: Session, comment_id: int, data: CommentUpdate, user_id: int):
    c = db.query(Comment).filter(Comment.id==comment_id).first()
    if not c:
        raise HTTPException(status_code=404, detail="Komentar tidak ditemukan")
    if c.user_id != user_id:
        raise HTTPException(status_code=403, detail="Bukan pemilik komentar")
    if data.comment:
        c.comment = data.comment
    db.commit()
    db.refresh(c)
    return c

def delete_comment(db: Session, comment_id: int, user_id: int):
    c = db.query(Comment).filter(Comment.id==comment_id).first()
    if not c:
        raise HTTPException(status_code=404, detail="Komentar tidak ditemukan")
    if c.user_id != user_id:
        raise HTTPException(status_code=403, detail="Bukan pemilik komentar")
    db.delete(c)
    db.commit()
