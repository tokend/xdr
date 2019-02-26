

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

//: ManageAssetAction is used to specify action to be performed over asset or asset create/update request
enum ManageAssetAction
{
    CREATE_ASSET_CREATION_REQUEST = 0,
    CREATE_ASSET_UPDATE_REQUEST = 1,
    CANCEL_ASSET_REQUEST = 2,
    CHANGE_PREISSUED_ASSET_SIGNER = 3,
    UPDATE_MAX_ISSUANCE = 4
};

//: CancelAssetRequest is used cancel `UPDATE_ASSET` or `CREATE_ASSET` request
struct CancelAssetRequest
{
    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: UpdateMaxIssuance is used to update max issuance of the asset.
struct UpdateMaxIssuance
{
    //: code of asset to be updated
    AssetCode assetCode;
    //: amount to be max issuance amount in asset entry
    uint64 maxIssuanceAmount;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/* ManageAssetOp

    Creates, updates or deletes asset

    Threshold: high

    Result: ManageAssetResult
*/

//: ManageAssetOp is used to:
//: * create or update `CREATE_ASSET` request;
//: * create or update `UPDATE_ASSET` request;
//: * cancel `CREATE_ASSET` or `UPDATE_ASSET` request
//: * change asset pre issuer
//: * update max issuance of asset
struct ManageAssetOp
{
    //: Use zero to create request, non zero to manage existing request
    uint64 requestID;

    //: data is used to pass one of `ManageAssetAction` with needed params
    union switch (ManageAssetAction action)
    {
    case CREATE_ASSET_CREATION_REQUEST:
        //: Is used to pass needed fields for `CREATE_ASSET`
        struct
        {
            //: Is used needed to pass needed fields to create asset entry
            AssetCreationRequest createAsset;
            //: Is used to pass tasks for reviewable request instead tasks from key value
            uint32* allTasks;

            //: reserved for future use
            union switch (LedgerVersion v)
            {
            case EMPTY_VERSION:
                void;
            }
            ext;
        } createAssetCreationRequest;
    case CREATE_ASSET_UPDATE_REQUEST:
        //: Is used to pass needed fields for `UPDATE_ASSET`
        struct
        {
            //: Is used needed to pass needed fields to update asset entry
            AssetUpdateRequest updateAsset;
            //: Is used to pass tasks for reviewable request instead tasks from key value
            uint32* allTasks;

            //: reserved for future use
            union switch (LedgerVersion v)
            {
            case EMPTY_VERSION:
                void;
            }
            ext;
        } createAssetUpdateRequest;
    case CANCEL_ASSET_REQUEST:
        //: Reserved for the future use
        CancelAssetRequest cancelRequest;
    case CHANGE_PREISSUED_ASSET_SIGNER:
        //: Is used to pass needed fields to change asset pre issuer
        AssetChangePreissuedSigner changePreissuedSigner;
    case UPDATE_MAX_ISSUANCE:
        //: Is used to update max issuance of asset
        UpdateMaxIssuance updateMaxIssuance;
    } request;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ManageAsset Result ********/

//: Result codes of ManageAssetOp
enum ManageAssetResultCode
{
    //: Means that specified action in `data` of ManageSignerOp was successfully executed
    SUCCESS = 0,                       // request was successfully created/updated/canceled

    // codes considered as "failure" for the operation
    //: There is no `CREATE_ASSET` or `UPDATE_ASSET` request with such id
    REQUEST_NOT_FOUND = -1,           // failed to find asset request with such id
    //: only asset pre issuer can change asset pre issuer
    INVALID_SIGNATURE = -2,
    //: Not allowed to create asset with code which already used for an other asset
    ASSET_ALREADY_EXISTS = -3,	      // asset with such code already exist
    //: Not allowed to set max issuance amount that
    //: less than sum of issued and pendingIssuance and available for issuance
    INVALID_MAX_ISSUANCE_AMOUNT = -4, // max issuance amount is 0
    //: Not allowed use asset code which is empty or contains space
    INVALID_CODE = -5,                // asset code is invalid (empty or contains space)
    //: Not allowed to set pre issuer equals to exiting pre issuer
    INVALID_PRE_ISSUER = -6,          // pre issuer is the same as existing
    //: Not allowed to set policies which is not declared
    INVALID_POLICIES = -7,            // asset policies (has flag which does not belong to AssetPolicies enum)
    //: There is no asset with such code
    ASSET_NOT_FOUND = -8,             // asset does not exists
    //: Request for such asset already exists
    REQUEST_ALREADY_EXISTS = -9,      // request for creation of unique entry already exists
    //: Not allowed to create two or more assets with `STATS_QUOTE_ASSET` policy
    STATS_ASSET_ALREADY_EXISTS = -10, // statistics quote asset already exists
    //: Not allowed to set pre issued amount that greater than max issuance amount
    INITIAL_PREISSUED_EXCEEDS_MAX_ISSUANCE = -11, // initial pre issued amount exceeds max issuance amount
    //: Not allowed to use details with invalid json structure
    INVALID_CREATOR_DETAILS = -12,                        // details must be a valid json
    //: Not allowed to set trailing digits count more than max trailing digits count (for now - 6)
    INVALID_TRAILING_DIGITS_COUNT = -13,          // invalid number of trailing digits
    //: Initial pre issued amount does not match precision set by trailing digits count
    INVALID_PREISSUED_AMOUNT_PRECISION = -14,
    //: Maximum issuance amount does not match precision set by trailing digits count
    INVALID_MAX_ISSUANCE_AMOUNT_PRECISION = -15,
    //: There is no value in key value by `asset_create_tasks` key,
    //: configuration does not allow to create asset
    ASSET_CREATE_TASKS_NOT_FOUND = -16,
    //: There is no value in key value by `asset_update_tasks` key,
    //: configuration does not allow to update asset
    ASSET_UPDATE_TASKS_NOT_FOUND = -17,
    //: Create `CREATE_ASSET` or `UPDATE_ASSET` allowed only with tasks from key value
    NOT_ALLOWED_TO_SET_TASKS_ON_UPDATE = -18
};

//: Is used to pass useful params after success applying of operation
struct ManageAssetSuccess
{
    //: ID of request which was created in the operation applying process
    uint64 requestID;
    //: True means that request was applied and execution flow was successful
    bool fulfilled;
    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Is used to return result of operation applying
union ManageAssetResult switch (ManageAssetResultCode code)
{
case SUCCESS:
    //: Result of successful operation applying
    ManageAssetSuccess success;
default:
    void;
};

}
