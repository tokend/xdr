

%#include "xdr/types.h"
%#include "xdr/reviewable-request-asset.h"
%#include "xdr/reviewable-request-issuance.h"
%#include "xdr/reviewable-request-withdrawal.h"
%#include "xdr/reviewable-request-sale.h"
%#include "xdr/reviewable-request-change-role.h"
%#include "xdr/reviewable-request-limits-update.h"
%#include "xdr/reviewable-request-AML-alert.h"
%#include "xdr/reviewable-request-update-sale-details.h"
%#include "xdr/reviewable-request-invoice.h"
%#include "xdr/reviewable-request-contract.h"
%#include "xdr/reviewable-request-atomic-swap-ask.h"
%#include "xdr/reviewable-request-atomic-swap-bid.h"
%#include "xdr/reviewable-request-create-poll.h"
%#include "xdr/reviewable-request-kyc-recovery.h"
%#include "xdr/reviewable-request-kyc-recovery.h"

namespace stellar
{

enum ReviewableRequestType
{
	NONE = 0, // use this request type in ReviewRequestOp extended result if additional info is not required
	ANY = 1,
	CREATE_ISSUANCE = 3,
	CREATE_WITHDRAW = 4,
	CHANGE_ROLE = 8,
	CREATE_ASSET = 10,
	UPDATE_ASSET = 13,
	KYC_RECOVERY = 18
};

union ReviewableRequestOperation switch (OperationType type)
{
case CREATE_ACCOUNT:
    CreateAccountOp createAccountOp;
case PAYMENT:
    PaymentOp paymentOp;
case CREATE_SIGNER:
    CreateSignerOp createSignerOp;
case UPDATE_SIGNER:
    UpdateSignerOp updateSignerOp;
case REMOVE_SIGNER:
    RemoveSignerOp removeSignerOp;
case CREATE_ROLE:
    CreateRoleOp createRoleOp;
case UPDATE_ROLE:
    UpdateRoleOp updateRoleOp;
case REMOVE_ROLE:
    RemoveRoleOp removeRoleOp;
case CREATE_RULE:
    CreateRuleOp createRuleOp;
case UPDATE_RULE:
    UpdateRuleOp updateRuleOp;
case REMOVE_RULE:
    RemoveRuleOp removeRuleOp;
case ISSUANCE:
    IssuanceOp issuanceOp;
case DESTRUCTION:
    DestructionOp destructionOp;
case CHANGE_ACCOUNT_ROLES:
    ChangeAccountRolesOp changeAccountRolesOp;
case CREATE_ASSET:
    CreateAssetOp createAssetOp;
};

// ReviewableRequest - request reviewable by admin
struct ReviewableRequestEntry
{
	uint64 requestID;
	Hash hash; // hash of the request body
	AccountID requestor;
    longstring rejectReason;
	int64 createdAt; // when request was created

	ReviewableRequestOperation operations<>;

	uint32 allTasks;
    uint32 pendingTasks;
    // maybe add sequenceNumber and creator details

    // External details vector consists of comments written by request reviewers
    longstring externalDetails<>;

	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
	}
    ext;
};

}
