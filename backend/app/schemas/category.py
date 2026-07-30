from pydantic import BaseModel, Field
from typing import Optional

class CategoryBase(BaseModel):
    kategori: str = Field(
        ..., 
        description="Nama kategori soal, contoh: Matematika, Sejarah", 
        min_length=2, 
        max_length=100, 
        example="Matematika"
    )
class CategoryCreate(CategoryBase):
    pass

class CategoryUpdate(BaseModel):
    kategori: Optional[str] = Field(
        None, 
        description="Nama kategori baru", 
        example="Fisika"
    )

class CategoryRead(CategoryBase):
    id: int = Field(
        ..., 
        description="ID unik kategori", 
        example=1
    )
    model_config = {"from_attributes": True}
