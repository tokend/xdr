%#include "xdr/ledger-entries-poll.h"

namespace stellar
{

//: CreatePollRequest is used to create poll entry with passed fields
struct CreatePollRequest
{
    //: is used to restrict using of poll through rules
    uint32 permissionType;

    //: Number of allowed choices
    uint32 numberOfChoices;

    //: Specification of poll
    PollData data;

    //: Arbitrary stringified json object with details about the poll
    longstring creatorDetails; // details set by requester

    //: The date from which voting in the poll will be allowed
    uint64 startTime;

    //: The date until which voting in the poll will be allowed
    uint64 endTime;

    //: ID of account which is responsible for poll result submitting
    AccountID resultProviderID;

    //: True means that signature of `resultProvider` is required to participate in poll voting
    bool voteConfirmationRequired;

    //: reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}