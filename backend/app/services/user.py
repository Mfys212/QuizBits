from sqlalchemy.orm import Session
from fastapi import HTTPException, status
from app.models.user import User
from app.models.question import Question
from app.schemas.user import UserCreate, UserUpdate
from app.core.security import hash_password
from app.services.activity_log import log_activity

def create_user(db: Session, data: UserCreate, actor_id: int = 0):
    if db.query(User).filter(User.email == data.email).first():
        raise HTTPException(status_code=400, detail="Email sudah terdaftar")
    if db.query(User).filter(User.username == data.username).first():
        raise HTTPException(status_code=400, detail="Username sudah terdaftar")
    user = User(email=data.email, username=data.username, password=hash_password(data.password), role=data.role)
    db.add(user)
    db.commit()
    db.refresh(user)
    log_activity(db, actor_id, "user", "create", user.id, f"User baru: {user.username}")
    return user

def get_users(db: Session):
    return db.query(User).all()

def get_user_by_id(db: Session, user_id: int):
    return db.query(User).filter(User.id == user_id).first()

def update_user(db: Session, user_id: int, data: UserUpdate, actor_id: int):
    user = get_user_by_id(db, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User tidak ditemukan")
    if data.email:
        user.email = data.email
    if data.username:
        user.username = data.username
    if data.role:
        user.role = data.role
    if data.password:
        user.password = hash_password(data.password)
    db.commit()
    db.refresh(user)
    log_activity(db, actor_id, "user", "update", user.id, f"Edit user: {user.username}")
    return user

def delete_user(db: Session, user_id: int, actor_id: int):
    user = get_user_by_id(db, user_id)
    if not user:
        raise HTTPException(status_code=404, detail="User tidak ditemukan")
    db.delete(user)
    db.commit()
    log_activity(db, actor_id, "user", "delete", user_id, f"Hapus user: {user.username}")

def count_users(db: Session):
    return db.query(User).count()

def count_questions_by_user(db: Session, user_id: int):
    return db.query(Question).filter(Question.user_id == user_id).count()
