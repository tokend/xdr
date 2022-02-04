%#include "xdr/types.h"

namespace stellar
{

//: Functional type of poll
enum PollType
{
    SINGLE_CHOICE = 0,
    CUSTOM_CHOICE = 1
};

//: PollData is used to pass `PollType` with necessary params
union PollData switch (PollType type)
{
case SINGLE_CHOICE:
    EmptyExt ext;
case CUSTOM_CHOICE:
	EmptyExt customChoiceExt;
};

struct PollEntry
{
    uint64 id;
    uint32 permissionType;

    uint32 numberOfChoices;
    PollData data;

    uint64 startTime;
    uint64 endTime;

    AccountID ownerID;
    AccountID resultProviderID;

    bool voteConfirmationRequired;

    longstring details;

    EmptyExt ext;
};

}