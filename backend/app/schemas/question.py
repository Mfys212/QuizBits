from pydantic import BaseModel, Field
from typing import List, Optional
from datetime import datetime

class QuestionBase(BaseModel):
    question: str = Field(
        ..., 
        description="Isi pertanyaan dari soal", 
        example="Apa ibukota Indonesia?"
    )
    correct_answer: str = Field(
        ..., 
        description="Kunci jawaban yang benar, harus sama dengan salah satu opsi", 
        example="Jakarta"
    )
    explanation: str = Field(
        ..., 
        description="Penjelasan kenapa jawaban itu benar"
    )
    cover_url: Optional[str] = Field(
        default="", 
        description="URL gambar cover soal (opsional)"
    )

class QuestionCreate(QuestionBase):
    category_id: int = Field(
        ..., 
        description="ID kategori soal", 
        example=1
    )
    answers: List[str] = Field(
        default=[], 
        description="List opsi jawaban minimal 2 opsi", 
        example=["Jakarta","Bandung","Surabaya","Medan"]
    )

class QuestionUpdate(BaseModel):
    question: Optional[str] = Field(
        None, 
        description="Isi pertanyaan baru"
    )
    correct_answer: Optional[str] = Field(
        None, 
        description="Kunci jawaban baru"
    )
    explanation: Optional[str] = Field(
        None, 
        description="Penjelasan baru"
    )
    category_id: Optional[int] = Field(
        None, 
        description="ID kategori baru"
    )
    cover_url: Optional[str] = Field(
        None, 
        description="URL cover baru"
    )
    answers: Optional[List[str]] = Field(
        None, 
        description="List opsi jawaban baru, replace semua yang lama"
    )

class AnswerRead(BaseModel):
    id: int = Field(
        ..., 
        description="ID jawaban"
    )
    answer: str = Field(
        ..., 
        description="Teks jawaban"
    )
    model_config = {"from_attributes": True}

class QuestionRead(QuestionBase):
    id: int = Field(
        ..., 
        description="ID unik soal", 
        example=1
    )
    views: int = Field(
        ..., 
        description="Jumlah dilihat", 
        example=100
    )
    answerer: int = Field(
        ..., 
        description="Jumlah penjawab", 
        example=25
    )
    created_at: datetime = Field(
        ..., 
        description="Waktu soal dibuat"
    )
    user_id: int = Field(
        ..., 
        description="ID pembuat soal"
    )
    category_id: int = Field(
        ..., 
        description="ID kategori soal"
    )
    answers: List[AnswerRead] = Field(
        default=[], 
        description="List opsi jawaban"
    )
    model_config = {"from_attributes": True}
