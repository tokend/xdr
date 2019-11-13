%#include "xdr/ledger-entries.h"

namespace stellar
{

struct CreateAssetOp
{
    AssetCode code;

    uint32 securityType; // use instead policies that limit usage, use in account rules
    uint32 state; 

	uint64 maxIssuanceAmount; // max number of tokens to be issued
    
    uint32 trailingDigitsCount;

    longstring details;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Result codes of ManageAssetOp
enum CreateAssetResultCode
{
    //: Specified action in `data` of ManageSignerOp was successfully performed
    SUCCESS = 0,                       // request was successfully created/updated/canceled

    //: It is not allowed to create an asset with a code that is already used for another asset
    ASSET_ALREADY_EXISTS = -1,	      // asset with such code already exist
    //: It is not allowed to set max issuance amount that is
    //: less than the sum of issued, pending issuance and available for issuance amounts
    INVALID_MAX_ISSUANCE_AMOUNT = -2, // max issuance amount is 0
    //: It is not allowed to use an asset code that is empty or contains space
    INVALID_CODE = -3,                // asset code is invalid (empty or contains space)
    //: It is not allowed to use details with invalid json structure
    INVALID_CREATOR_DETAILS = -4,                        // details must be a valid json
    //: It is not allowed to set a trailing digits count greater than the maximum trailing digits count (6 at the moment)
    INVALID_TRAILING_DIGITS_COUNT = -5,          // invalid number of trailing digits
    //: Maximum issuance amount precision and asset precision are mismatched
    INVALID_MAX_ISSUANCE_AMOUNT_PRECISION = -6
};

//: Is used to return the result of operation application
union CreateAssetResult switch (CreateAssetResultCode code)
{
case SUCCESS:
    //: Result of successful operation application
    EmptyExt exy;
default:
    void;
};

}
