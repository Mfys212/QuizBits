from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.core.database import get_db
from app.core.dependencies import get_current_user
from app.schemas.comment import CommentCreate, CommentUpdate, CommentRead
from app.services.comment import create_comment, get_comments_by_question, update_comment, delete_comment
from app.models.user import User

router = APIRouter(prefix="/comments", tags=["comments"])

@router.post("/", response_model=CommentRead)
def create(data: CommentCreate, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    return create_comment(db, data, current_user.id)

@router.get("/question/{question_id}", response_model=list[CommentRead])
def list_by_question(question_id: int, db: Session = Depends(get_db)):
    return get_comments_by_question(db, question_id)

@router.put("/{comment_id}", response_model=CommentRead)
def update(comment_id: int, data: CommentUpdate, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    return update_comment(db, comment_id, data, current_user.id)

@router.delete("/{comment_id}")
def delete(comment_id: int, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    delete_comment(db, comment_id, current_user.id)
    return {"message": "Komentar dihapus"}
