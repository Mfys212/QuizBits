from pydantic import BaseModel, Field
from typing import Optional

class AnswerBase(BaseModel):
    answer: str = Field(
        ...,
        description="Opsi Jawaban dari Pertanyaan"
    )

class AnswerCreate(AnswerBase):
    pass

class AnswerUpdate(BaseModel):
    answer: Optional[str] = Field(
        None,
        description="Opsi Jawaban dari Pertanyaan (jika kosong tidak diubah)"
    )

class AnswerRead(AnswerBase):
    id: int = Field(
        ...,
        description="ID Jawaban"
    )
    model_config = {
        "from_attributes": True
    }
