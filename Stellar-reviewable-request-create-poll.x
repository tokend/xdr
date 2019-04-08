%#include "xdr/Stellar-ledger-entries-poll.h"

namespace stellar
{

//: CreatePollRequest is used to create poll entry with passed fields
struct CreatePollRequest
{
    //: is used to restrict the usage of a poll under the rules
    uint32 permissionType;

    //: Number of allowed choices
    uint32 numberOfChoices;

    //: Specification of a poll
    PollData data;

    //: Arbitrary stringified json object with details about a poll
    longstring creatorDetails; // details set by requester

    //: The date after which the voting in a poll will be allowed
    uint64 startTime;

    //: The date before which the voting in a poll will be allowed
    uint64 endTime;

    //: ID of account responsible for submitting the poll result
    AccountID resultProviderID;

    //: True means that a signature of `resultProvider` is required to participate in poll voting
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