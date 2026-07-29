from pydantic import BaseModel, Field
from datetime import datetime
from typing import List, Optional
from answer import AnswerCreate, AnswerUpdate, AnswerRead

class QuestionBase(BaseModel):
    question: str = Field(
        ...,
        description="Isi Pertanyaan"
    )
    correct_answer: str = Field(
        ...,
        description="Jawaban yang Benar"
    )
    explanation: str = Field(
        ...,
        description="Penjelasan Jawaban dari Soal"
    )

class QuestionCreate(QuestionBase):
    answers: List[AnswerCreate] = []

class QuestionUpdate(BaseModel):
    question: Optional[str] = Field(
        ...,
        description="Isi Pertanyaan (jika kosong tidak diubah)"
    )
    correct_answer: Optional[str] = Field(
        ...,
        description="Jawaban yang Benar (jika kosong tidak diubah)"
    )
    explanation: Optional[str] = Field(
        ...,
        description="Penjelasan Jawaban dari Soal (jika kosong tidak diubah)"
    )
    answers: Optional[List[AnswerUpdate]] = []

class QuestionRead(QuestionBase):
    id: int = Field(
        ...,
        description="ID Soal"
    )
    views: int = Field(
        ...,
        description="Jumlah Pembaca"
    )
    answerer: int = Field(
        ...,
        description="Jumlah Penjawab"
    )
    created_at: datetime = Field(
        ...,
        description="Waktu Soal Dibuat"
    )
    user: str = Field(
        ...,
        description="Pembuat Soal"
    )
    answers: List[AnswerRead] = []
    model_config = {
        "from_attributes": True
    }