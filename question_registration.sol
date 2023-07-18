pragma solidity ^0.5.1;



library SafeMath {
 
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    if (a == 0) {
      return 0;
    }
    uint256 c = a * b;
    assert(c / a == b);
    return c;
  }
 
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }
 
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }
 
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}




/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
contract Context {
    // Empty internal constructor, to prevent people from mistakenly deploying
    // an instance of this contract, which should be used via inheritance.
    constructor () internal { }
    // solhint-disable-previous-line no-empty-blocks

    function _msgSender() internal view returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () internal {
        _owner = _msgSender();
        emit OwnershipTransferred(address(0), _owner);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(isOwner(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Returns true if the caller is the current owner.
     */
    function isOwner() public view returns (bool) {
        return _msgSender() == _owner;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public onlyOwner {
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     */
    function _transferOwnership(address newOwner) internal {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}


contract QuiztokSurvey is Ownable  {
    
    
    
    
    struct surveyInfo {
        string surveyName;
        string surveyUser;
        string surveySubject;
        string surveyDescript;
    }
    
    struct surveyQuestion {
        uint surveyId;
        string questionNumber;
        string title;
        string option1;
        string option2;
        string option3;
        string option4;
        string option5;
    }
    
    struct surveyUserHistory{
        uint surveyId;
        string questionNumber;
        string uidx;
        string uuid;
        string email;
        string selectedAnswer;
    }
    
    struct surveyUserResult{
        uint surveyId;
        string questionNumber;
        string selectedNumber;
        string selectedNumberCount;
        string createTime;
        string updateTime;
    }
    
    

    mapping(uint => surveyUserResult) surveyUserResults;
    mapping(uint => surveyUserHistory) surveyUserHistorys;
    mapping(uint => surveyInfo) surveys;
    mapping(uint => surveyQuestion) surveyQuestions;
    uint[] public surveyIds;
    surveyQuestion[] public questions;
    surveyUserHistory[] public historyDatas;
    surveyUserResult[] public surveyUserResultDatas;
    
    
    
    

    
    function getSurveyUserResultIndexNum() public view returns(uint){
        return surveyUserResultDatas.length;
    }
    
    function getSurveyUserResultIndex(uint i) public view returns (uint , string memory, string memory, string memory, string memory, string memory ){
        return (surveyUserResultDatas[i].surveyId, surveyUserResultDatas[i].questionNumber, surveyUserResultDatas[i].selectedNumber, surveyUserResultDatas[i].selectedNumberCount , surveyUserResultDatas[i].createTime, surveyUserResultDatas[i].updateTime);
    }
    
    function getSurveyUserResult(uint id) public view returns (uint , string memory, string memory, string memory, string memory, string memory ){
        surveyUserResult storage r  = surveyUserResults[id];
        return (r.surveyId, r.questionNumber, r.selectedNumber, r.selectedNumberCount , r.createTime, r.updateTime);
    }
        
    function registerSurveyUserResult(uint _surveyId, string memory _questionNumber, string memory  _selectedNumber, string memory _selectedNumberCount, string memory _createTime , string memory _updateTime   ) public onlyOwner {
        

        surveyUserResult storage newSurveyUserResult  = surveyUserResults[_surveyId];
        newSurveyUserResult.surveyId = _surveyId;
        newSurveyUserResult.questionNumber = _questionNumber;
        newSurveyUserResult.selectedNumber = _selectedNumber;
        newSurveyUserResult.selectedNumberCount = _selectedNumberCount;
        newSurveyUserResult.createTime = _createTime;
        newSurveyUserResult.updateTime = _updateTime;
        surveyUserResultDatas.push(newSurveyUserResult);
        
        
        
    }
    
    
    function getUserHistoryIndexNum() public view returns(uint){
        return historyDatas.length;
    }
    
    function getSurveyUserHistory(uint id) public view returns (uint, string memory,string memory,string memory,string memory,string memory ) {
        surveyUserHistory storage h = surveyUserHistorys[id];
        return (h.surveyId, h.questionNumber, h.uidx, h.uuid, h.email, h.selectedAnswer);
    }
    
        function getSurveyUserHistoryIndex(uint i) public view returns (uint, string memory,string memory,string memory,string memory,string memory ) {
        
        return (historyDatas[i].surveyId, historyDatas[i].questionNumber, historyDatas[i].uidx, historyDatas[i].uuid, historyDatas[i].email, historyDatas[i].selectedAnswer);
    }
    
    function registerSurveyUserHistory(uint _surveyId, string memory _questionNumber, string memory _uidx , string memory  _uuid, string memory _email, string memory _selectedAnswer ) public onlyOwner{
        surveyUserHistory storage newSurveyUserHistorys = surveyUserHistorys[_surveyId];
        newSurveyUserHistorys.surveyId = _surveyId;
        newSurveyUserHistorys.questionNumber = _questionNumber;
        newSurveyUserHistorys.uidx = _uidx;
        newSurveyUserHistorys.uuid = _uuid;
        newSurveyUserHistorys.email= _email;
        newSurveyUserHistorys.selectedAnswer = _selectedAnswer;
        historyDatas.push(newSurveyUserHistorys);
    }
    
    function getQuestionIndexNum() public view returns(uint) {
      return questions.length;
    }    
    
    function registerSurveyQuestion(uint _surveyId, string  memory _questionNumber, string memory _title , 
                                    string memory _option1, string memory _option2, string memory _option3, string memory _option4, string memory _option5) public onlyOwner {
        uint id = _surveyId;
        surveyQuestion storage newSurveyQuestion = surveyQuestions[id];
        
        newSurveyQuestion.surveyId = id;
        newSurveyQuestion.questionNumber = _questionNumber;
        newSurveyQuestion.title = _title;
        
        
        newSurveyQuestion.option1 = _option1;
        newSurveyQuestion.option2 = _option2;
        newSurveyQuestion.option3 = _option3;
        newSurveyQuestion.option4 = _option4;
        newSurveyQuestion.option5 = _option5;

        questions.push(newSurveyQuestion);
    }
    
    function getSurveyIndexNum() public view returns(uint) {
      uint blockCount = surveyIds.length;
      return blockCount;
    }
    
    function registerSurvey(string memory _surveyName, string memory _surveyUser, string memory _surveySubject , string memory _surveyDescript ) public onlyOwner {
        uint id = getSurveyIndexNum()+1;
        surveyInfo storage newSurvey = surveys[id];
        newSurvey.surveyName = _surveyName;
        newSurvey.surveyUser = _surveyUser;
        newSurvey.surveySubject = _surveySubject;
        newSurvey.surveyDescript = _surveyDescript;
        surveyIds.push(id);
    }
    
    function getSurvey(uint id) public view returns(string memory, string memory,string memory, string memory) {
        surveyInfo storage s = surveys[id];
        return (s.surveyName, s.surveyUser, s.surveySubject, s.surveyDescript);
    }
    
    function getSurveyName(uint id) public view returns(string memory) {
        surveyInfo storage s = surveys[id];
        return (s.surveyName);
    }
    
    function getSurveyQuestion(uint i) public view returns(uint , string memory, string memory, string memory, string memory, string memory, string memory ){
        return (questions[i].surveyId , questions[i].title, questions[i].option1, questions[i].option2 ,  questions[i].option3, questions[i].option4, questions[i].option5);
    }
    
    function getSurveyQuestionSurveyId(uint i) public view returns(uint ){
       return questions[i].surveyId;
    }
     
    function getSurveyQuestionQuestionNumber(uint i) public view returns(string memory ){
       return questions[i].questionNumber;
    }
       
    function getSurveyQuestionTitle(uint i) public view returns(string memory ){
       return questions[i].title;
    }
   
    function getSurveyQuestionOptions(uint i) public view returns(string memory,string memory, string memory, string memory, string memory  ){
       return (questions[i].option1, questions[i].option2, questions[i].option3, questions[i].option4, questions[i].option5);
    }
}