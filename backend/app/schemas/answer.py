from pydantic import BaseModel, Field
from typing import Optional

class AnswerBase(BaseModel):
    answer: str = Field(
        ..., 
        description="Teks opsi jawaban", 
        example="Jakarta adalah ibukota Indonesia"
    )

class AnswerCreate(AnswerBase):
    pass

class AnswerUpdate(BaseModel):
    answer: Optional[str] = Field(
        None, 
        description="Teks opsi jawaban baru"
    )

class AnswerRead(AnswerBase):
    id: int = Field(
        ..., 
        description="ID unik jawaban", 
        example=1
    )
    model_config = {"from_attributes": True}
