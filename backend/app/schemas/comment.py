from pydantic import BaseModel, Field
from typing import Optional
from datetime import datetime

class CommentBase(BaseModel):
    comment: str = Field(
        ...,
        description="Komentar User untuk Soal"
    )

class CommentCreate(CommentBase):
    pass

class CommentUpdate(BaseModel):
    comment: Optional[str] = Field(
        None,
        description="Komentar User untuk Soal (jika kosong tidak diubah)"
    )

class CommentRead(CommentBase):
    id: int = Field(
        ...,
        description="ID Komentar"
    )
    user: str = Field(
        ...,
        description="User yang Komen"
    )
    created_at: datetime = Field(
        ...,
        description="Waktu Komen Dibuat"
    )
    model_config = {
        "from_attributes": True
    }
