from pydantic import BaseModel, EmailStr, Field
from typing import Optional, Literal

class UserBase(BaseModel):
    email: EmailStr = Field(
        ..., 
        description="Email unik user, harus valid", 
        example="user@quizbits.com"
    )
    username: str = Field(
        ..., 
        description="Username unik user untuk login", 
        min_length=3, 
        max_length=50, 
        example="hudamifta"
    )
    role: Literal["developer","admin","user"] = Field(
        default="user", 
        description="Role hak akses"
    )
    
class UserCreate(UserBase):
    password: str = Field(
        ..., 
        description="Password minimal 6 karakter", 
        min_length=6, 
        example="Hudamifta212"
    )

class UserUpdate(BaseModel):
    email: Optional[EmailStr] = Field(
        None, 
        description="Email baru"
    )
    username: Optional[str] = Field(
        None, 
        description="Username baru", 
        min_length=3
    )
    role: Optional[Literal["developer","admin","user"]] = Field(
        None, 
        description="Role baru"
    )
    password: Optional[str] = Field(
        None, 
        description="Password baru minimal 6 karakter", 
        min_length=6
    )

class UserResponse(UserBase):
    id: int = Field(
        ..., 
        description="ID unik user", 
        example=1
    )
    model_config = {"from_attributes": True}

class Count(BaseModel):
    total_user: int = Field(
        ..., 
        description="Total jumlah user terdaftar", 
        example=10
    )
    total_question: int = Field(
        ..., 
        description="Total jumlah soal yang dibuat user login", 
        example=5
    )
