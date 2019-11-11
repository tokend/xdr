namespace stellar 
{

struct UpdateAssetOp 
{
    AssetCode code;
    longstring *details;
	uint64 *maxIssuanceAmount;
	uint32 *state;

    EmptyExt ext;
};

enum UpdateAssetResultCode 
{
    SUCCESS = 0,

    NOT_FOUND = -1,
    INVALID_DETAILS = -2,
    UNSUFFICIENT_MAX_ISSUANCE_AMOUNT = -3,
    NOT_DEFINED_UPDATE = -4
};

union UpdateAssetResult switch(UpdateAssetResultCode code) 
{
case SUCCESS:
    EmptyExt ext;
default:
    void;
};


}