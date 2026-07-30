from pydantic import BaseModel, Field
from typing import Optional
from datetime import datetime

class CommentBase(BaseModel):
    comment: str = Field(
        ..., 
        description="Isi komentar untuk soal", 
        min_length=1, 
        example="Soalnya keren banget!"
    )
    
class CommentCreate(CommentBase):
    question_id: int = Field(
        ..., 
        description="ID soal yang dikomentari", 
        example=1
    )

class CommentUpdate(BaseModel):
    comment: Optional[str] = Field(
        None, 
        description="Isi komentar baru"
    )

class CommentRead(CommentBase):
    id: int = Field(
        ..., 
        description="ID unik komentar"
    )
    user_id: int = Field(
        ..., 
        description="ID user pembuat komentar"
    )
    question_id: int = Field(
        ..., 
        description="ID soal yang dikomentari"
    )
    created_at: datetime = Field(
        ..., 
        description="Waktu komentar dibuat"
    )
    model_config = {"from_attributes": True}
