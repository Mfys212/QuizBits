from pydantic import BaseModel, Field
from datetime import datetime

class MessageCreate(BaseModel):
    user2_id: int = Field(
        ...,
        description="ID user lawan bicara yang mau diajak chat, tidak boleh ID sendiri",
        example=2
    )

class MessageRead(BaseModel):
    id: int = Field(
        ...,
        description="ID unik conversation / percakapan",
        example=1
    )
    created_at: datetime = Field(
        ...,
        description="Waktu conversation pertama kali dibuat",
        example="2026-07-30T10:00:00Z"
    )
    user1_id: int = Field(
        ...,
        description="ID user pertama (pembuat conversation)",
        example=1
    )
    user2_id: int = Field(
        ...,
        description="ID user kedua (lawan bicara)",
        example=2
    )

    model_config = {"from_attributes": True}