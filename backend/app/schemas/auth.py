from pydantic import BaseModel, EmailStr, Field
from typing import Optional, Literal

class LoginRequest(BaseModel):
    email_username: str = Field(
        ..., 
        description="Email atau username yang dipakai buat login", 
        example="hudamifta212@gmail.com"
    )
    password: str = Field(
        ..., 
        description="Password akun user", 
        example="Hudamifta212"
    )

class TokenResponse(BaseModel):
    access_token: str = Field(
        ..., 
        description="JWT access token untuk akses endpoint auth"
    )
    token_type: str = Field(
        default="bearer", 
        description="Tipe token, selalu bearer"
    )
    message: str = Field(
        default="Login sukses", 
        description="Pesan status login"
    )

class LogOutResponse(BaseModel):
    message: str = Field(
        default="Logout sukses", 
        description="Pesan status logout"
    )

class UserMe(BaseModel):
    sub: str = Field(
        ...,
        description="ID user yang login"
    )
    email: EmailStr = Field(
        ...,
        description="Email user yang login"
    )
    username: str = Field(
        ...,
        description="Username user yang login"
    )
    role: str = Field(
        ...,
        description="Role user yang login"
    )
    model_config = {
        "from_attributes": True
    }

class RegisterRequest(BaseModel):
    email: EmailStr = Field(
        ..., 
        description="Email untuk registrasi, harus unik dan valid", 
        example="userbaru@quizbits.com"
    )
    username: str = Field(
        ..., 
        description="Username unik untuk login, minimal 3 karakter", 
        min_length=3, 
        max_length=50, 
        example="userbaru"
    )
    password: str = Field(
        ..., 
        description="Password minimal 6 karakter, akan di-hash bcrypt", 
        min_length=6, 
        example="Password123"
    )
    role: Optional[Literal["user", "admin", "developer"]] = Field(
        default="user", 
        description="Role user, default user. Hanya developer yang bisa bikin admin/developer via endpoint admin"
    )

class RegisterResponse(BaseModel):
    id: int = Field(
        ..., 
        description="ID user yang baru dibuat", 
        example=1
    )
    email: EmailStr = Field(
        ..., 
        description="Email user baru"
    )
    username: str = Field(
        ..., 
        description="Username user baru"
    )
    role: str = Field(
        ..., 
        description="Role user baru"
    )
    message: str = Field(
        default="Registrasi berhasil", 
        description="Pesan sukses registrasi"
    )
    model_config = {"from_attributes": True}