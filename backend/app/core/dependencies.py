from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from sqlalchemy.orm import Session
from app.core.database import get_db
from app.core.security import decode_access_token
from app.models.user import User

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/auth/login")

def get_current_user(token: str = Depends(oauth2_scheme), db: Session = Depends(get_db)) -> User:
    payload = decode_access_token(token)
    if not payload:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Token tidak valid atau expired")
    user_id = payload.get("sub")
    if not user_id:
        raise HTTPException(status_code=401, detail="Token tidak valid")
    user = db.query(User).filter(User.id == int(user_id)).first()
    if not user:
        raise HTTPException(status_code=401, detail="User tidak ditemukan")
    return user

def get_current_active_user(current_user: User = Depends(get_current_user)):
    return current_user

def get_current_admin(current_user: User = Depends(get_current_user)):
    if current_user.role not in ["admin", "developer"]:
        raise HTTPException(status_code=403, detail="Butuh role admin")
    return current_user

def get_current_developer(current_user: User = Depends(get_current_user)):
    if current_user.role != "developer":
        raise HTTPException(status_code=403, detail="Butuh role developer")
    return current_user
