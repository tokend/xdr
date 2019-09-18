%#include "xdr/types.h"

namespace stellar
{
/* FeeEntry     
Entry representing a fee state.
*/

//: `FeeType` represents different types of fees for different operations (e.g. fee charged on withdrawal or on investment)
enum FeeType
{
    PAYMENT_FEE = 0,
    OFFER_FEE = 1,
    WITHDRAWAL_FEE = 2,
    ISSUANCE_FEE = 3,
    INVEST_FEE = 4, // fee to be taken while creating the sale participation
    CAPITAL_DEPLOYMENT_FEE = 5, // fee to be taken when the sale closes
    OPERATION_FEE = 6,
    PAYOUT_FEE = 7,
    ATOMIC_SWAP_SALE_FEE = 8,
    ATOMIC_SWAP_PURCHASE_FEE = 9,
    SWAP_FEE = 10
};

//: (not used) `EmissionFeeType` is a subtype of `ISSUANCE_FEE`
enum EmissionFeeType
{
    PRIMARY_MARKET = 1,
    SECONDARY_MARKET = 2
};

//: `PaymentFeeType` is a subtype of the Fee used for payments
enum PaymentFeeType
{
    OUTGOING = 1,
    INCOMING = 2
};

//: `FeeEntry` is used in the system configuration to set fees for different assets, operations (according to FeeType), particular account roles, particular accounts,
//: or globally (only if both parameters particular account role and paticular account are not specified).
struct FeeEntry
{
    //: Type of a particular fee depending on the operation (e.g., PAYMENT_FEE for payment operation, WITHDRAWAL_FEE for withdrawal operation, etc.)
    FeeType feeType;
    //: Code of an asset used in the operation for which the fee will be charged
    AssetCode asset;

    //: Fixed amount of fee that will be charged for the operation
    int64 fixedFee;
    //: Percent from the operation amount that will be charged for the corresponding operation
    int64 percentFee;

    //: (optional) Account for which a fee is set in the system
    AccountID* accountID;
    //: (optional) Account for which a fee is set in the system
    uint64*    accountRole;
    //: Defines a `subtype` of a fee if such exists (e.g., `OUTGOING` or `INCOMING` for `PAYMENT_FEE`)
    int64 subtype;

    //: Defines the lower bound of operation amount for which this fee is applicable
    int64 lowerBound;
    //: Defines the upper bound of operation amount for which this fee is applicable
    int64 upperBound;

    //: Hash of `type:<feeType>asset:<asset>subtype:<subtype>`
    //: (Add `accountID:<accountID>` or `accountRole:<accountRole>` if corresponding fields are defined)
    Hash hash;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
