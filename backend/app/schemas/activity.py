from pydantic import BaseModel, Field
from datetime import datetime
from typing import Optional

class ActivityRead(BaseModel):
    id: int = Field(
        ..., 
        description="ID unik log aktivitas"
    )
    user_id: Optional[int] = Field(
        None, 
        description="ID user pelaku aktivitas, null kalau sistem"
    )
    module: str = Field(
        ..., 
        description="Nama modul yang diubah, contoh: user, question, comment", 
        example="question"
    )
    action: str = Field(
        ..., 
        description="Jenis aksi: create, update, delete", 
        example="create"
    )
    object_id: int = Field(
        ..., 
        description="ID objek yang diutak-atik", 
        example=10
    )
    description: str = Field(
        ..., 
        description="Deskripsi aktivitas di dashboard", 
        example="Buat soal: Apa ibukota Indonesia?"
    )
    created_at: datetime = Field(
        ..., 
        description="Waktu aktivitas terjadi"
    )
    model_config = {"from_attributes": True}
