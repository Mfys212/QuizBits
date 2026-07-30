from sqlalchemy.orm import Session
from fastapi import HTTPException
from app.models.category import Category
from app.schemas.category import CategoryCreate, CategoryUpdate

def create_category(db: Session, data: CategoryCreate):
    if db.query(Category).filter(Category.kategori == data.kategori).first():
        raise HTTPException(status_code=400, detail="Kategori sudah ada")
    cat = Category(kategori=data.kategori)
    db.add(cat)
    db.commit()
    db.refresh(cat)
    return cat

def get_categories(db: Session):
    return db.query(Category).all()

def get_category(db: Session, cat_id: int):
    return db.query(Category).filter(Category.id == cat_id).first()

def update_category(db: Session, cat_id: int, data: CategoryUpdate):
    cat = get_category(db, cat_id)
    if not cat:
        raise HTTPException(status_code=404, detail="Kategori tidak ditemukan")
    if data.kategori:
        cat.kategori = data.kategori
    db.commit()
    db.refresh(cat)
    return cat

def delete_category(db: Session, cat_id: int):
    cat = get_category(db, cat_id)
    if not cat:
        raise HTTPException(status_code=404, detail="Kategori tidak ditemukan")
    db.delete(cat)
    db.commit()
