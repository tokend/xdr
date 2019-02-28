

%#include "xdr/Stellar-types.h"
namespace stellar
{
/* FeeEntry     
Entry representing a fee state.
*/

//: `enum FeeType` represents different types of fee for different operations
enum FeeType
{
    PAYMENT_FEE = 0,
    OFFER_FEE = 1,
    WITHDRAWAL_FEE = 2,
    ISSUANCE_FEE = 3,
    INVEST_FEE = 4, // fee to be taken while creating sale participation
    CAPITAL_DEPLOYMENT_FEE = 5, // fee to be taken when sale close
    OPERATION_FEE = 6,
    PAYOUT_FEE = 7,
    ATOMIC_SWAP_SALE_FEE = 8,
    ATOMIC_SWAP_PURCHASE_FEE = 9
};

//: (not used) `EmissionFeeType` is a subtype of the Fee used for issuance
enum EmissionFeeType
{
    PRIMARY_MARKET = 1,
    SECONDARY_MARKET = 2
};

// `PaymentFeeType` is a subtype of the Fee used for payments
enum PaymentFeeType
{
    OUTGOING = 1,
    INCOMING = 2
};

//: `FeeEntry` is used to set fees to charge either from a particular Account or all Accounts with the particular AccountRole or globally in the system for different operations.
//: * If `accountID` is defined - fee is charged from a particular account.
//: * If `accountRole` is defined - fee is charged from all accounts with such account role
//: * If both are undefined - fee is set globally for all members of the system
struct FeeEntry
{
    //: Type of the particular FeeEntry. Defines type of the fee based on the type of operation for which fee would be charged.
    FeeType feeType;
    //: Asset of operation in which fee is applicable
    AssetCode asset;

    //: Fixed amount to pay for the operation
    int64 fixedFee;
    //: Percent of operation amount to be charged
    int64 percentFee;

    //: (optional) Account from which fee would be charged
    AccountID* accountID;
    //: (optional) Account role from which fee would be charged
    uint64*    accountRole;
    //: Subtype of fee defines fee applicability to the particular operation
    int64 subtype;

    //: Defines the lower bound of operation amount for which this fee is applicable
    int64 lowerBound;
    //: Defines upper bound of operation amount for which this fee is applicable
    int64 upperBound;

    //: Hash of the fee entry (sha256 of stringified feeType, asset, subtype, accountID and accountRole)
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
