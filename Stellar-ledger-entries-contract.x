%#include "xdr/Stellar-types.h"

namespace stellar
{

enum ContractState
{
    NO_CONFIRMATIONS = 0,
    CUSTOMER_CONFIRMED = 1,
    CONTRACTOR_CONFIRMED = 2,
    DISPUTING = 4,
    REVERTING_RESOLVE = 8,
    NOT_REVERTING_RESOLVE = 16
};

struct DisputeDetails
{
    AccountID disputer;
    longstring reason;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct ContractEntry
{
    uint64 contractID;

    AccountID contractor;
    AccountID customer;
    AccountID escrow;

    uint64 startTime;
    uint64 endTime;
    longstring details<>;
    uint64 invoiceRequestsIDs<>;

    uint32 state;
    DisputeDetails *disputeDetails;

    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}