%#include "xdr/Stellar-ledger-entries-poll.h"

namespace stellar
{

struct CreatePollRequest
{
    uint64 permissionType;

    uint64 numberOfChoices;
    PollData data;

    longstring creatorDetails; // details set by requester

    uint64 startTime;
    uint64 endTime;

    AccountID resultProviderID;
    bool signatureRequired;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}