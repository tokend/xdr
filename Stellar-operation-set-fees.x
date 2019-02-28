

%#include "xdr/Stellar-ledger-entries.h"
%#include "xdr/Stellar-ledger-entries-fee.h"

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
        //: `isDelete` indicates that fee should be either set or removed
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
        //: `SetFeesOp` was successfully applied and fee was successfully set or deleted
        SUCCESS = 0,

        // codes considered as "failure" for an operation
        //: Fee amount is invalid (e.g. negative amount is ranked invalid)
        INVALID_AMOUNT = -1,
        //: `FeeType` which is set in `FeeEntry` struct is invalid (any `FeeType` not contained in `FeeType` enum is ranked invalid)
        INVALID_FEE_TYPE = -2,
        //: `AssetCode` specified in `FeeEntry` is not presented in the system
        ASSET_NOT_FOUND = -3,
        //: `AssetCode` specified in `FeeEntry` is invalid (e.g. `AssetCode` which not consists of alphanumeric symbols or zeros in `AssetCode` are not trailing) TODO
        INVALID_ASSET = -4,
        //: Malformed operation (e.g. `upperBound` from `FeeEntry` struct is less than `lowerBound`)
        MALFORMED = -5,
        //: Malformed range is defined by `FeeEntry.lowerBound` and `FeeEntry.upperBound` (`lowerBound` must be equal to 0 & `upperBound` must be equal to `INT64_MAX`)
        MALFORMED_RANGE = -6,
        //: Range defined by `lowerBound` and `upperBound` in `FeeEntry` overlaps with at least one other `FeeEntry` range
        RANGE_OVERLAP = -7,
        //: There is no fee to delete (this code could be returned only on deleting fee)
        NOT_FOUND = -8,
        //: `FeeEntry` has not default subtype or fee asset is not base
        SUB_TYPE_NOT_EXIST = -9,
        //: `FeeEntry` version is greater than ledger version (Deprecated? We don't use ledger version anymore)
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
        //: Calculated fee hash differs from hash taken from db
        INVALID_FEE_HASH = -17,
        //: Fixed fee amount must fit asset precision
        INVALID_AMOUNT_PRECISION = -18
    };
    
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
