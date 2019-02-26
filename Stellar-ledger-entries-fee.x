

%#include "xdr/Stellar-types.h"
namespace stellar
{
/* FeeEntry     
Entry representing a fee state.
*/

//: `FeeType` represents different types of fee for different operations (e.g. fee charged on withdrawal of on investment)
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

enum EmissionFeeType
{
    PRIMARY_MARKET = 1,
    SECONDARY_MARKET = 2
};

// `PaymentFeeType` defines FeeTypes for sender and for receiver of the payment
enum PaymentFeeType
{
    OUTGOING = 1,
    INCOMING = 2
};

// `FeeEntry` represents the fee structure with the corresponding details
struct FeeEntry
{
    //: Type of the particular FeeEntry
    FeeType feeType;
    //: Asset in which fee would be charged
    AssetCode asset;

    //: Fee paid for the operation
    int64 fixedFee;
    //: Percent of transfer amount to be charged
    int64 percentFee;

    //: (optional) Account from which fee would be charged
    AccountID* accountID;
    //: (optional) Account role from which fee would be charged
    uint64*    accountRole;
    //: For example, different withdrawals — bars or coins
    int64 subtype;

    //: Defines the lower bound of operation amount for which this fee could be applied
    int64 lowerBound;
    //: Defines upper bound of operation amount for which this fee could be applied
    int64 upperBound;

    //: Hash of the fee entry
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
