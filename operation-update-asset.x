namespace stellar 
{

struct UpdateAssetOp 
{
    AssetCode code;
    longstring details;
	uint64 maxIssuanceAmount;

    EmptyExt ext;
};

enum UpdateAssetResultCode 
{
    SUCCESS = 0,

    NOT_FOUND = -1
};

union UpdateAssetResult switch(UpdateAssetResultCode code) 
{
case SUCCESS:
    EmptyExt ext;
default:
    void;
};


}