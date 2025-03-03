from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from models.database import SessionLocal
from models.tenant import Tenant
from schemas.tenant import TenantCreate

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.post("/tenants/", response_model=TenantCreate)
def create_tenant(tenant: TenantCreate, db: Session = Depends(get_db)):
    existing = db.query(Tenant).filter(Tenant.domain == tenant.domain).first()
    if existing:
        raise HTTPException(status_code=400, detail="Tenant already exists")
    new_tenant = Tenant(**tenant.dict())
    db.add(new_tenant)
    db.commit()
    db.refresh(new_tenant)
    return new_tenant
