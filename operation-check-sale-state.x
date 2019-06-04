

%#include "xdr/ledger-entries.h"
%#include "xdr/operation-manage-offer.h"

namespace stellar
{

/* CheckSaleState
Closes or cancels sale if conditions for that are met.
Threshold: med

Result: CheckSaleStateResult

*/
//: CheckSaleState operation is used to perform check on sale state - whether the sale was successful or not
struct CheckSaleStateOp
{
    //:ID of the sale to check
    uint64 saleID;
    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* CheckSaleState Result ********/
//: Result codes of CheckSaleState operation
enum CheckSaleStateResultCode
{
    // codes considered as "success" for the operation
    //: CheckSaleState operation was successfully applied
    SUCCESS = 0,

    // codes considered as "failure" for the operation
    //: Sale with provided ID not found
    NOT_FOUND = -1,
    //: Sale was not processed, because it's still active
    NOT_READY = -2
};
//: Effect of performed check sale state operation
enum CheckSaleStateEffect {
    //: Sale hasn't reached the soft cap before end time
    CANCELED = 1,
    //: Sale has either reached the soft cap and ended or reached hard cap
    CLOSED = 2,
    //: Crowdfunding sale was successfully closed and the price for the base asset was updated according to participants contribution
    UPDATED = 3
};
//: Entry for additional information regarding sale cancel
struct SaleCanceled {
    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Entry for additional information regarding sale update
struct SaleUpdated {
    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Entry for additional information regarding sub sale closing
struct CheckSubSaleClosedResult {
    //: Balance in base asset of the closed sale
    BalanceID saleBaseBalance;
    //: Balance in one of the quote assets of the closed sale
    BalanceID saleQuoteBalance;
    //: Result of an individual offer made during the sale and completed on its close
    ManageOfferSuccessResult saleDetails;
    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
      void;
    }
    ext;
};

//: Entry for additional information regarding sale closing
struct CheckSaleClosedResult {
    //: AccountID of the sale owner
    AccountID saleOwner;
    //: Array of individual's contribution details
    CheckSubSaleClosedResult results<>;
    //: Reserved for future use
    union switch (LedgerVersion v)
    {
      case EMPTY_VERSION:
        void;
    }
    ext;
};
//: Result of the successful application of CheckSaleState operation
struct CheckSaleStateSuccess
{
    //: ID of the sale being checked
    uint64 saleID;
    //: Additional information regarding eventual result
    union switch (CheckSaleStateEffect effect)
    {
    case CANCELED:
        SaleCanceled saleCanceled;
    case CLOSED:
        CheckSaleClosedResult saleClosed;
    case UPDATED:
        SaleUpdated saleUpdated;
    }
    effect;
     //: Reserved for future use
    union switch (LedgerVersion v)
    {
      case EMPTY_VERSION:
        void;
    }
    ext;
};
//: Result of the CheckSaleState operation along with the result code
union CheckSaleStateResult switch (CheckSaleStateResultCode code)
{
case SUCCESS:
    CheckSaleStateSuccess success;
default:
    void;
};

}

