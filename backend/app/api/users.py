from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.core.database import get_db
from app.core.dependencies import get_current_user, get_current_admin
from app.schemas.user import UserCreate, UserResponse, UserUpdate, Count
from app.services.user import create_user, get_users, get_user_by_id, update_user, delete_user, count_users, count_questions_by_user
from app.models.user import User

router = APIRouter(prefix="/users", tags=["users"])

@router.post("/", response_model=UserResponse)
def create(data: UserCreate, db: Session = Depends(get_db), current_user: User = Depends(get_current_admin)):
    return create_user(db, data, current_user.get("id"))

@router.get("/", response_model=list[UserResponse])
def list_users(db: Session = Depends(get_db), current_user: User = Depends(get_current_admin)):
    return get_users(db)

@router.get("/{user_id}", response_model=UserResponse)
def get_user(user_id: int, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    return get_user_by_id(db, user_id)

@router.put("/{user_id}", response_model=UserResponse)
def update(user_id: int, data: UserUpdate, db: Session = Depends(get_db), current_user: User = Depends(get_current_admin)):
    return update_user(db, user_id, data, current_user.get("id"))

@router.delete("/{user_id}")
def delete(user_id: int, db: Session = Depends(get_db), current_user: User = Depends(get_current_admin)):
    delete_user(db, user_id, current_user.get("id"))
    return {"message": "User dihapus"}

@router.get("/stats/count", response_model=Count)
def stats(db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    total = count_users(db)
    my_q = count_questions_by_user(db, current_user.get("id"))
    return Count(total_user=total, total_question=my_q)
