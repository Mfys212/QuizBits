from pydantic import BaseModel, Field
from typing import Optional
from datetime import datetime

class RatingBase(BaseModel):
    rating: int = Field(
        ..., 
        description="Nilai rating 1 sampai 5 bintang", 
        ge=1, 
        le=5, 
        example=5
    )

class RatingCreate(RatingBase):
    question_id: int = Field(
        ..., 
        description="ID soal yang mau di-rating", 
        example=1
    )

class RatingUpdate(BaseModel):
    rating: Optional[int] = Field(
        None, 
        description="Nilai rating baru 1-5", 
        ge=1, 
        le=5
    )

class RatingRead(RatingBase):
    id: int = Field(
        ..., 
        description="ID unik rating"
    )
    user_id: int = Field(
        ..., 
        description="ID user pemberi rating"
    )
    question_id: int = Field(
        ..., 
        description="ID soal yang di-rating"
    )
    created_at: datetime = Field(
        ..., 
        description="Waktu rating dibuat"
    )
    model_config = {"from_attributes": True}
