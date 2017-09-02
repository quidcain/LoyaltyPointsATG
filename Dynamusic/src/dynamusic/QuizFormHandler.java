package dynamusic;

import atg.droplet.GenericFormHandler;
import atg.servlet.DynamoHttpServletRequest;
import atg.servlet.DynamoHttpServletResponse;

public class QuizFormHandler extends GenericFormHandler {
	private String question;
	private String answer;
	private String userAnswer;
	private boolean correctAnswer;
	private String validateSuccessURL;
	private String validateErrorURL;
	
	public QuizFormHandler() {
		// TODO Auto-generated constructor stub
	}

	public boolean handleValidate (DynamoHttpServletRequest request, DynamoHttpServletResponse response) 
			throws java.io.IOException {
		// If any form errors were generated, abort...
		if (getFormError()) {
			if (getValidateErrorURL() != null) {
				response.sendLocalRedirect(getValidateErrorURL(),request);
				return false;
			}
			return true;
		}

		// Otherwise, redirect to form submission success page,
		// setting answer flag to reflect correctness of answer
		if (getUserAnswer().equalsIgnoreCase(getAnswer()))
			setCorrectAnswer(true);
		else
			setCorrectAnswer(false);
		if (getValidateSuccessURL() != null) {
			response.sendLocalRedirect(getValidateSuccessURL(),request);
			return false;
		}
		return true;
	}
	
	public boolean handleCancel (DynamoHttpServletRequest request, DynamoHttpServletResponse response) throws java.io.IOException {
		setUserAnswer(null);
		return true;
	}
	
	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public String getUserAnswer() {
		return userAnswer;
	}

	public void setUserAnswer(String userAnswer) {
		this.userAnswer = userAnswer;
	}

	public boolean isCorrectAnswer() {
		return correctAnswer;
	}

	public void setCorrectAnswer(boolean correctAnswer) {
		this.correctAnswer = correctAnswer;
	}

	public String getValidateSuccessURL() {
		return validateSuccessURL;
	}

	public void setValidateSuccessURL(String validateSuccessURL) {
		this.validateSuccessURL = validateSuccessURL;
	}

	public String getValidateErrorURL() {
		return validateErrorURL;
	}

	public void setValidateErrorURL(String validateErrorURL) {
		this.validateErrorURL = validateErrorURL;
	}
	
}
