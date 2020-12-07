address 0x2 {

/// This module defines the types and methods used for the travel-rule data exchange.
module TravelRule {
    use 0x1::Option::Option;

    // status
    const STATUS_NONE: u8 = 0;
    const STATUS_NEEDS_KYC_DATA: u8 = 1;
    const STATUS_NEEDS_RECIPIENT_SIGNATURE: u8 = 2;
    const STATUS_READY_FOR_SETTLMENT: u8 = 3;
    const STATUS_ABORT: u8 = 4;
    const STATUS_PENDING_REVIEW: u8 = 5;
    const STATUS_SOFT_MATCH: u8 = 6;

    struct StatusObject {
        status: u8,
        abort_code: Option<u8>,
        abort_message: Option<vector<u8>>,
    }

    // payment
    const PAYMENT_ACTION_CHARGE: u8 = 0;

    struct PaymentActionObject<CoinType> {
        amount: u64,
        currency: CoinType,
        action: u8,
        timestamp: u64,
    }

    // national id
    struct NationalIdObject {
        id_value: vector<u8>,
        country: Option<vector<u8>>,
        type: Option<vector<u8>>,
    }

    // address
    struct AddressObject {
        city: Option<vector<u8>>,
        country: Option<vector<u8>>,
        line1: Option<vector<u8>>,
        line2: Option<vector<u8>>,
        postal_code: Option<vector<u8>>,
        state: Option<vector<u8>>,
    }

    // kyc data
    const KYC_DATA_PAYLOAD_TYPE_DEFAULT: u8 = 0;

    const KYC_DATA_TYPE_INDIVIDUAL: u8 = 0;
    const KYC_DATA_TYPE_ENTITY: u8 = 1;

    struct KYCDataObject {
        payload_type: u8,
        payload_version: u8,
        type: u8,
        given_name: Option<vector<u8>>,
        surname: Option<vector<u8>>,
        address: Option<AddressObject>,
        dob: Option<vector<u8>>,
        place_of_birth: Option<AddressObject>,
        national_id: Option<NationalIdObject>,
        legal_entity_name: Option<vector<u8>>,
        additional_kyc_data: Option<vector<u8>>,
    }

    // payment actor
    struct PaymentActorObject {
        address: vector<u8>,
        kyc_data: Option<KYCDataObject>,
        status: StatusObject,
        metadata: vector<vector<u8>>,
    }

    // payment object
    struct PaymentObject<CoinType> {
        sender: PaymentActorObject,
        receiver: PaymentActorObject,
        reference_id: vector<u8>,
        original_payment_reference_id: Option<vector<u8>>,
        recipient_signature: Option<vector<u8>>,
        action: PaymentActionObject<CoinType>,
        description: vector<u8>,
    }
}
}
