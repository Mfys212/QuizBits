from pydantic import BaseModel, EmailStr, Field

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