from fastapi import Depends, HTTPException
from fastapi_microsoft_auth import AzureAuthorizationCodeBearer
from fastapi import FastAPI

# Initialize the app
app = FastAPI()

# Use 'common' for multi-tenant apps
auth_scheme = AzureAuthorizationCodeBearer(
    authority="https://login.microsoftonline.com/common",
    client_id="<Your Azure Client ID>",
    client_secret="<Your Azure Client Secret>",
    scopes=["User.Read"],
)

@app.get("/protected")
async def protected_route(token: str = Depends(auth_scheme)):
    try:
        user = await auth_scheme.get_current_user(token)
        # Validate tenant if needed
        tenant_id = user.id_token.get("tid")
        if not tenant_id:
            raise HTTPException(status_code=401, detail="Invalid tenant")
        return {"message": f"Welcome, {user.name}, from tenant {tenant_id}!"}
    except Exception as e:
        raise HTTPException(status_code=401, detail=str(e))
