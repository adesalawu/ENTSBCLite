from fastapi import FastAPI
from routers import tenants
from auth.azure_auth import auth_scheme
from models.database import init_db
from routers import sip_trunk


app = FastAPI()

# Initialize database
init_db()

# Authentication
@app.get("/protected-route", dependencies=[Depends(auth_scheme)])
def protected_route():
    return {"message": "This route is protected!"}

# Routers
app.include_router(tenants.router, prefix="/api/v1/tenants", tags=["Tenants"])

app.include_router(sip_trunk.router, prefix="/api/v1/sip_trunks", tags=["SIP Trunks"])
