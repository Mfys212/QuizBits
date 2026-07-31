from fastapi import APIRouter, Depends, HTTPException, Response, status
from sqlalchemy.orm import Session
from app.core.database import get_db
from app.schemas.auth import LoginRequest, TokenResponse, UserMe, LogOutResponse, RegisterRequest, RegisterResponse
from app.services.auth import login_user
from app.core.dependencies import get_current_user
from app.core.security import ACCESS_TOKEN_EXPIRE_MINUTES, hash_password
from app.models.user import User

router = APIRouter(prefix="/auth", tags=["auth"])

@router.post("/login", response_model=TokenResponse)
def login(data: LoginRequest, response: Response, db: Session = Depends(get_db)):
    token = login_user(db, data.email_username, data.password)
    if not token:
        raise HTTPException(status_code=401, detail="Email/Username atau password salah")
    
    response.set_cookie(
        key="access_token",
        value=token,
        httponly=True,
        secure=False,      # True di production (HTTPS)
        samesite="lax",
        path="/",
        max_age=ACCESS_TOKEN_EXPIRE_MINUTES * 60
    )

    return TokenResponse(access_token=token, message="Login sukses")

@router.post("/logout", response_model=LogOutResponse)
def logout(response: Response):
    response.delete_cookie(key="access_token", path="/")
    return LogOutResponse(message="Logout sukses")

@router.get("/me", response_model=UserMe)
def me(current_user: User = Depends(get_current_user)):
    return current_user

@router.post("/register", response_model=RegisterResponse, status_code=status.HTTP_201_CREATED, summary="Register user baru")
def register(data: RegisterRequest, db: Session = Depends(get_db)):
    """
    Registrasi user baru - public endpoint, tidak butuh auth.
    Role default adalah 'user'. Kalau mau bikin admin/developer harus lewat /users/ pakai akun admin.
    """
    # Cek email sudah ada
    if db.query(User).filter(User.email == data.email).first():
        raise HTTPException(status_code=400, detail="Email sudah terdaftar, pakai email lain")
    
    # Cek username sudah ada
    if db.query(User).filter(User.username == data.username).first():
        raise HTTPException(status_code=400, detail="Username sudah terdaftar, pakai username lain")
    
    # Untuk register public, paksa role jadi user biar gak bisa langsung jadi admin
    # Kecuali kalau mau izinkan admin register, bisa hapus baris ini
    role_to_create = "user"
    # Kalau mau izinkan pilih role tapi cuma user yang boleh self-register:
    # if data.role in ["admin", "developer"]:
    #     role_to_create = "user"
    # else:
    #     role_to_create = data.role
    
    # Buat user baru
    new_user = User(
        email=data.email,
        username=data.username,
        password=hash_password(data.password),
        role=role_to_create
    )
    
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    
    return RegisterResponse(
        id=new_user.id,
        email=new_user.email,
        username=new_user.username,
        role=new_user.role,
        message="Registrasi berhasil, silakan login"
    )


@router.post("/register/admin", response_model=RegisterResponse, summary="Register admin/developer (butuh auth admin)")
def register_admin(data: RegisterRequest, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    """
    Register dengan role custom (admin/developer) - butuh login sebagai admin/developer dulu
    """
    if current_user.get("role") not in ["admin", "developer"]:
        raise HTTPException(status_code=403, detail="Hanya admin/developer yang bisa bikin user dengan role admin/developer")
    
    if db.query(User).filter(User.email == data.email).first():
        raise HTTPException(status_code=400, detail="Email sudah terdaftar")
    
    if db.query(User).filter(User.username == data.username).first():
        raise HTTPException(status_code=400, detail="Username sudah terdaftar")
    
    new_user = User(
        email=data.email,
        username=data.username,
        password=hash_password(data.password),
        role=data.role
    )
    
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    
    return RegisterResponse(
        id=new_user.id,
        email=new_user.email,
        username=new_user.username,
        role=new_user.role,
        message=f"User {data.role} berhasil dibuat oleh {current_user.get("username")}"
    )
