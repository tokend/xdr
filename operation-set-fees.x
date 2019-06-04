

%#include "xdr/ledger-entries.h"
%#include "xdr/ledger-entries-fee.h"

namespace stellar
{
    /* SetFeesOp
     
     Creates, updates or deletes fees
     
     Threshold: high
     
     Result: SetFeesEmissionRequestResult
     */
    //: Allows to establish or remove a relationship between a particular fee entry with the different entities
    struct SetFeesOp
    {
        //: Fee entry to set
        FeeEntry* fee;
        //: `isDelete` indicates that a fee should be either set or removed
        bool isDelete;
        //: reserved for future use
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
        ext;
    };

    /******* SetFeesEmissionRequest Result ********/

    //: Result codes for SetFees operation
    enum SetFeesResultCode
    {
        // codes considered as "success" for the operation
        //: `SetFeesOp` was successfully applied and a fee was successfully set or deleted
        SUCCESS = 0,

        // codes considered as "failure" for an operation
        //: Fee amount is invalid (e.g. negative amount is ranked invalid)
        INVALID_AMOUNT = -1,
        //: `FeeType` is invalid (any `FeeType` that is not contained in the `FeeType` enum is ranked invalid)
        INVALID_FEE_TYPE = -2,
        //: `AssetCode` is not presented in the system
        ASSET_NOT_FOUND = -3,
        //: `AssetCode` is invalid (e.g. `AssetCode` that does not consist of alphanumeric symbols)
        INVALID_ASSET = -4,
        //: Malformed operation (e.g. `upperBound` from the `FeeEntry` structure is less than `lowerBound`)
        MALFORMED = -5,
        //: Malformed range is defined by `FeeEntry.lowerBound` and `FeeEntry.upperBound` (`lowerBound` must be equal to 0 & `upperBound` must be equal to `INT64_MAX`)
        MALFORMED_RANGE = -6,
        //: Range defined by `lowerBound` and `upperBound` in `FeeEntry` overlaps with at least one another `FeeEntry` range
        RANGE_OVERLAP = -7,
        //: There is no fee to delete (this code could be returned only on deleting a fee)
        NOT_FOUND = -8,
        //: `FeeEntry` does not have a default subtype or the fee asset is not base
        SUB_TYPE_NOT_EXIST = -9,
        //: Reserved for future use
        INVALID_FEE_VERSION = -10,
        //: Reserved for future use
        INVALID_FEE_ASSET = -11,
        //: Reserved for future use
        FEE_ASSET_NOT_ALLOWED = -12, // feeAsset can be set only if feeType is PAYMENT
        //: Reserved for future use
        CROSS_ASSET_FEE_NOT_ALLOWED = -13, // feeAsset on payment fee type can differ from asset only if payment fee subtype is OUTGOING
        //: Reserved for future use
        FEE_ASSET_NOT_FOUND = -14,
        //: Reserved for future use
        ASSET_PAIR_NOT_FOUND = -15, // cannot create cross asset fee entry without existing asset pair
        //: Reserved for future use
        INVALID_ASSET_PAIR_PRICE = -16,
        //: Calculated fee hash differs from a hash taken from the database
        INVALID_FEE_HASH = -17,
        //: Fixed fee amount must fit asset precision
        INVALID_AMOUNT_PRECISION = -18,
        //: There is no account with passed ID
        ACCOUNT_NOT_FOUND = -19,
        //: There is no role with passed ID
        ROLE_NOT_FOUND = -20
    };

    //: Is used to pass result of operation applying
    union SetFeesResult switch (SetFeesResultCode code)
    {
        case SUCCESS:
            struct {
                //: reserved for future use
                union switch (LedgerVersion v)
                {
                case EMPTY_VERSION:
                    void;
                }
                ext;
            } success;
        default:
            void;
    };
    
}
