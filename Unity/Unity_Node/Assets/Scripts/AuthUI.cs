using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class AuthUI : MonoBehaviour
{
    public InputField usernameInput;
    public InputField passwordInput;

    public Button registerButton;
    public Button loginButton;
    public Button logoutButton;
    public Button getDataButton;



    public Text statusText;

    private AuthManager authManager;
    void Start()
    {
        authManager = GetComponent<AuthManager>();   
        registerButton.onClick.AddListener(OnRegisterClick);
        loginButton.onClick.AddListener(OnLoginClick);
        logoutButton.onClick.AddListener(OnLogoutClick);
        getDataButton.onClick.AddListener(OnGetDataClick);
    }

    void OnRegisterClick()
    {
        StartCoroutine(RegisterCoroutine());
    }
    void OnLoginClick()
    {
        StartCoroutine(LoginCoroutine());
    }
    void OnLogoutClick()
    {
        StartCoroutine(LogoutCoroutine());
    }
    void OnGetDataClick()
    {
        StartCoroutine(GetDataCoroutine());
    }
    private IEnumerator RegisterCoroutine()
    {
        statusText.text = "ȸ������ ��...";
        yield return StartCoroutine(authManager.Register(usernameInput.text, passwordInput.text));
        statusText.text = "ȸ������ ����, �α��� ���ּ���";
    }
    private IEnumerator LoginCoroutine()
    {
        statusText.text = "�α��� ��...";
        yield return StartCoroutine(authManager.Login(usernameInput.text, passwordInput.text));
        statusText.text = "�α��� ����";
    }
    private IEnumerator LogoutCoroutine()
    {
        statusText.text = "�α׾ƿ� ��...";
        yield return StartCoroutine(authManager.LogOut());
        statusText.text = "�α׾ƿ� ����";
    }
    private IEnumerator GetDataCoroutine()
    {
        statusText.text = "������ ��û ��...";
        yield return StartCoroutine(authManager.GetProtectedData());
        statusText.text = "������ ��û �Ϸ�";
    }
}
