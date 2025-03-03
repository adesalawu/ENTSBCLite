from pydantic import BaseModel

class SIPTrunkBase(BaseModel):
    provider_name: str
    domain: str
    credentials: str
    region: str | None = None
    max_channels: int | None = None

class SIPTrunkCreate(SIPTrunkBase):
    tenant_id: int

class SIPTrunkRead(SIPTrunkBase):
    id: int

    class Config:
        orm_mode = True
