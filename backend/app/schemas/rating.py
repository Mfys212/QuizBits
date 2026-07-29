from pydantic import BaseModel, Field
from typing import Optional
from datetime import datetime

class CommentBase(BaseModel):
    rating: int = Field(
        ...,
        description="Rating User untuk Soal"
    )

class CommentCreate(CommentBase):
    pass

class CommentUpdate(BaseModel):
    rating: Optional[int] = Field(
        None,
        description="Rating User untuk Soal (jika kosong tidak diubah)"
    )

class CommentRead(CommentBase):
    id: int = Field(
        ...,
        description="ID rating"
    )
    user: str = Field(
        ...,
        description="User yang Rating"
    )
    created_at: datetime = Field(
        ...,
        description="Waktu Komen Dibuat"
    )
    model_config = {
        "from_attributes": True
    }
