from fastapi import Depends, HTTPException, status, Request
from fastapi.security import OAuth2PasswordBearer
from sqlalchemy.orm import Session
from app.core.database import get_db
from app.core.security import decode_access_token
from app.models.user import User

# oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/auth/login")

def get_current_user(request: Request, db: Session = Depends(get_db)) -> User:
    token = request.cookies.get("access_token")
    if not token:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Not authenticated"
        )
    payload = decode_access_token(token)
    if not payload:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Token tidak valid atau expired")
    user_id = payload.get("sub")
    if not user_id:
        raise HTTPException(status_code=401, detail="Token tidak valid")
    user = db.query(User).filter(User.id == int(user_id)).first()
    if not user:
        raise HTTPException(status_code=401, detail="User tidak ditemukan")
    return payload

def get_current_active_user(current_user: User = Depends(get_current_user)):
    return current_user

def get_current_admin(current_user: User = Depends(get_current_user)):
    if current_user.get("role") not in ["admin", "developer"]:
        raise HTTPException(status_code=403, detail="Butuh role admin")
    return current_user

def get_current_developer(current_user: User = Depends(get_current_user)):
    if current_user.get("role") != "developer":
        raise HTTPException(status_code=403, detail="Butuh role developer")
    return current_user
