

%#include "xdr/types.h"
%#include "xdr/reviewable-request-change-role.h"
%#include "xdr/reviewable-request-kyc-recovery.h"

namespace stellar
{

enum ReviewableRequestType
{
	NONE = 0, // use this request type in ReviewRequestOp extended result if additional info is not required
	ANY = 1,
	CHANGE_ROLE = 2,
	KYC_RECOVERY = 3
};

struct TasksExt {
    // Tasks are represented by a bitmask
    uint32 allTasks;
    uint32 pendingTasks;

    // External details vector consists of comments written by request reviewers
    longstring externalDetails<>;

    // Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

// ReviewableRequest - request reviewable by admin
struct ReviewableRequestEntry {
	uint64 requestID;
	Hash hash; // hash of the request body
	AccountID requestor;
	longstring rejectReason;
	AccountID reviewer;
	string64* reference; // reference for request which will act as an unique key for the request (will reject request with the same reference from same requestor)
	int64 createdAt; // when request was created

	union switch (ReviewableRequestType type) {
        case CHANGE_ROLE:
            ChangeRoleRequest changeRoleRequest;
        case KYC_RECOVERY:
            KYCRecoveryRequest kycRecoveryRequest;
	} body;

	TasksExt tasks;

	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
	}
    ext;
};

}
