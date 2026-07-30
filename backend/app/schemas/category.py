from pydantic import BaseModel, Field
from typing import Optional

class CategoryBase(BaseModel):
    kategori: str = Field(
        ...,
        description="Kategori Question/Pertanyaan"
    )

class CategoryCreate(CategoryBase):
    pass

class CategoryUpdate(BaseModel):
    kategori: Optional[str] = Field(
        None,
        description="Kategori Question/Pertanyaan (jika kosong tidak diubah)"
    )

class CategoryRead(CategoryBase):
    id: int = Field(
        ...,
        description="ID Kategori"
    )
    model_config = {
        "from_attributes": True
    }
