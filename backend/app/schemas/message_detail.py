from pydantic import BaseModel, Field
from datetime import datetime
from typing import Optional

class MessageDetailBase(BaseModel):
    text: str = Field(
        ...,
        description="Isi Pesan"
    )

class MessageDetailCreate(MessageDetailBase):
    pass

class MessageDetailUpdate(BaseModel):
    text: Optional[str] = Field(
        None,
        description="Isi Pesan (jika kosong tidak diubah)"
    )

class MessageDetailRead(MessageDetailBase):
    id: int = Field(
        ...,
        description="ID Pesan"
    )
    created_at: datetime = Field(
        ...,
        description="Waktu Pesan Dibuat"
    )
    user: str = Field(
        ...,
        description="User yang Buat Pesan"
    )
    model_config = {
        "from_attributes": True
    }
