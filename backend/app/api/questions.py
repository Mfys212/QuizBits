from fastapi import APIRouter, Depends, Request
from sqlalchemy.orm import Session
from typing import Optional
from app.core.database import get_db
from app.core.dependencies import get_current_user
from app.schemas.question import QuestionCreate, QuestionUpdate, QuestionRead
from app.services.question import create_question, get_questions, get_question, update_question, delete_question, increment_view
from app.models.user import User

router = APIRouter(prefix="/questions", tags=["questions"])

@router.post("/", response_model=QuestionRead)
def create(data: QuestionCreate, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    return create_question(db, data, current_user.id)

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
    return update_question(db, q_id, data, current_user.id)

@router.delete("/{q_id}")
def delete(q_id: int, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    delete_question(db, q_id, current_user.id)
    return {"message": "Soal dihapus"}
