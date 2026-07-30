from pydantic import BaseModel, Field
from datetime import datetime

class MessageDetailBase(BaseModel):
    text: str = Field(
        ..., 
        description="Isi pesan chat", 
        min_length=1, 
        example="Halo, soal nomor 5 gimana jawabnya?"
    )

class MessageDetailCreate(MessageDetailBase):
    message_id: int = Field(
        ..., 
        description="ID conversation tempat pesan dikirim", 
        example=1
    )

class MessageDetailRead(MessageDetailBase):
    id: int = Field(
        ..., 
        description="ID unik pesan", 
        example=1
    )
    created_at: datetime = Field(
        ..., 
        description="Waktu pesan dikirim"
    )
    user_id: int = Field(
        ..., 
        description="ID pengirim pesan", 
        example=1
    )
    message_id: int = Field(
        ..., 
        description="ID conversation induk pesan", 
        example=1
    )
    model_config = {"from_attributes": True}
