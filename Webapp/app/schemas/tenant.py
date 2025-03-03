from pydantic import BaseModel

class TenantCreate(BaseModel):
    domain: str
    admin_email: str
    sip_trunk_provider: str
