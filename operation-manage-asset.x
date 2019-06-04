%#include "xdr/ledger-entries.h"

namespace stellar
{

//: ManageAssetAction is used to specify an action to be performed with an asset or asset create/update request
enum ManageAssetAction
{
    CREATE_ASSET_CREATION_REQUEST = 0,
    CREATE_ASSET_UPDATE_REQUEST = 1,
    CANCEL_ASSET_REQUEST = 2,
    CHANGE_PREISSUED_ASSET_SIGNER = 3,
    UPDATE_MAX_ISSUANCE = 4
};

//: CancelAssetRequest is used to cancel an `UPDATE_ASSET` or `CREATE_ASSET` request
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

//: UpdateMaxIssuance is used to update max issuance amount of an asset.
struct UpdateMaxIssuance
{
    //: `assetCode` defines an asset entry that will be updated
    AssetCode assetCode;
    //: new max issuance amount for an asset entry
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
//: * update max issuance of an asset
struct ManageAssetOp
{
    //: ID of a reviewable request
    //: If `requestID == 0`, operation creates a new reviewable request; otherwise, it updates the existing one 
    uint64 requestID;

    //: data is used to pass one of `ManageAssetAction` with required params
    union switch (ManageAssetAction action)
    {
    case CREATE_ASSET_CREATION_REQUEST:
        //: Is used to pass required fields for `CREATE_ASSET`
        struct
        {
            //: Is used to pass required fields to create an asset entry
            AssetCreationRequest createAsset;
            //: (optional) Bit mask whose flags must be cleared in order for `CREATE_ASSET` request to be approved, which will be used by key `asset_create_tasks`
            //: instead of key-value
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
            //: Is used to pass required fields to update an asset entry
            AssetUpdateRequest updateAsset;
            //: (optional) Bit mask whose flags must be cleared in order for `UPDATE_ASSET` request to be approved, which will be used
            //: instead of key-value by key `asset_update_tasks`
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
        //: Reserved for future use
        CancelAssetRequest cancelRequest;
    case CHANGE_PREISSUED_ASSET_SIGNER:
        //: Is used to pass required fields to change an asset pre issuer
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
    //: Specified action in `data` of ManageSignerOp was successfully performed
    SUCCESS = 0,                       // request was successfully created/updated/canceled

    // codes considered as "failure" for an operation
    //: There is no `CREATE_ASSET` or `UPDATE_ASSET` request with such id
    REQUEST_NOT_FOUND = -1,           // failed to find an asset request with such id
    //: only asset pre issuer can manage asset
    INVALID_SIGNATURE = -2,
    //: It is not allowed to create an asset with a code that is already used for another asset
    ASSET_ALREADY_EXISTS = -3,	      // asset with such code already exist
    //: It is not allowed to set max issuance amount that is
    //: less than the sum of issued, pending issuance and available for issuance amounts
    INVALID_MAX_ISSUANCE_AMOUNT = -4, // max issuance amount is 0
    //: It is not allowed to use an asset code that is empty or contains space
    INVALID_CODE = -5,                // asset code is invalid (empty or contains space)
    //: It is not allowed to set a pre issuer that is the same as an existing one
    INVALID_PRE_ISSUER = -6,          // pre issuer is the same as an existing one
    //: It is not allowed to set policies that are not declared
    INVALID_POLICIES = -7,            // asset policies (has flag which does not belong to AssetPolicies enum)
    //: There is no asset with such code
    ASSET_NOT_FOUND = -8,             // asset does not exists
    //: Request for such asset already exists
    REQUEST_ALREADY_EXISTS = -9,      // request for creation of unique entry already exists
    //: It is not allowed to create two or more assets with `STATS_QUOTE_ASSET` policy
    STATS_ASSET_ALREADY_EXISTS = -10, // statistics quote asset already exists
    //: It is not allowed to set a pre issued amount that is greater than the max issuance amount
    INITIAL_PREISSUED_EXCEEDS_MAX_ISSUANCE = -11, // initial pre issued amount exceeds max issuance amount
    //: It is not allowed to use details with invalid json structure
    INVALID_CREATOR_DETAILS = -12,                        // details must be a valid json
    //: It is not allowed to set a trailing digits count greater than the maximum trailing digits count (6 at the moment)
    INVALID_TRAILING_DIGITS_COUNT = -13,          // invalid number of trailing digits
    //: Pre issued amount precision and asset precision are mismatched
    INVALID_PREISSUED_AMOUNT_PRECISION = -14,
    //: Maximum issuance amount precision and asset precision are mismatched
    INVALID_MAX_ISSUANCE_AMOUNT_PRECISION = -15,
    //: There is no value in the key value by `asset_create_tasks` key
    //: (i.e., it is not allowed to perform asset creation)
    ASSET_CREATE_TASKS_NOT_FOUND = -16,
    //: There is no value in key value by `asset_update_tasks` key,
    //:  (i.e., it is not allowed to perform asset update)
    ASSET_UPDATE_TASKS_NOT_FOUND = -17,
    //: It is not allowed to set `allTasks` on the update of a rejected request.
    NOT_ALLOWED_TO_SET_TASKS_ON_UPDATE = -18
};

//: Is used to pass useful params after the successful operation application
struct ManageAssetSuccess
{
    //: ID of the request that was created in the process of operation application 
    uint64 requestID;
    //: True means that the request was applied and execution flow was successful
    bool fulfilled;
    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Is used to return the result of operation application
union ManageAssetResult switch (ManageAssetResultCode code)
{
case SUCCESS:
    //: Result of successful operation application
    ManageAssetSuccess success;
default:
    void;
};

}
