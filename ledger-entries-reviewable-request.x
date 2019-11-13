

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
case UPDATE_ASSET:
    UpdateAssetOp updateAssetOp;
case PUT_KEY_VALUE:
    PutKeyValueOp putKeyValueOp;
case REMOVE_KEY_VALUE:
    RemoveKeyValueOp removeKeyValueOp;
case CREATE_DATA:
    CreateDataOp createDataOp;
case UPDATE_DATA:
    UpdateDataOp updateDataOp;
case REMOVE_DATA:
    RemoveDataOp removeDataOp;
case CREATE_BALANCE:
    CreateBalanceOp createBalanceOp;
case INITIATE_KYC_RECOVERY:
    InitiateKYCRecoveryOp initiateKYCRecoveryOp;
case KYC_RECOVERY:
    KYCRecoveryOp kycRecoveryOp;

};

// ReviewableRequest - request reviewable by admin
struct ReviewableRequestEntry
{
	uint64 requestID;
	Hash hash; // hash of the request body

    uint32 securityType; // responsible for operations (types, count)

	AccountID requestor;
    longstring rejectReason;
	int64 createdAt; // when request was created

	ReviewableRequestOperation operations<>;

	uint64 allTasks;
    uint64 pendingTasks;
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
