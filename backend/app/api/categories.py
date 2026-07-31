from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.core.database import get_db
from app.core.dependencies import get_current_user, get_current_admin
from app.schemas.category import CategoryCreate, CategoryUpdate, CategoryRead
from app.services.category import create_category, get_categories, get_category, update_category, delete_category
from app.models.user import User

router = APIRouter(prefix="/categories", tags=["categories"])

@router.post("/", response_model=CategoryRead)
def create(data: CategoryCreate, db: Session = Depends(get_db), current_user: User = Depends(get_current_admin)):
    return create_category(db, data)

@router.get("/", response_model=list[CategoryRead])
def list_all(db: Session = Depends(get_db)):
    return get_categories(db)

@router.get("/{cat_id}", response_model=CategoryRead)
def get_one(cat_id: int, db: Session = Depends(get_db)):
    return get_category(db, cat_id)

@router.put("/{cat_id}", response_model=CategoryRead)
def update(cat_id: int, data: CategoryUpdate, db: Session = Depends(get_db), current_user: User = Depends(get_current_admin)):
    return update_category(db, cat_id, data)

@router.delete("/{cat_id}")
def delete(cat_id: int, db: Session = Depends(get_db), current_user: User = Depends(get_current_admin)):
    delete_category(db, cat_id)
    return {"message": "Kategori dihapus"}
